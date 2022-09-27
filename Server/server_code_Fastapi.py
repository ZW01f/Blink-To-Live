    import asyncio
from typing import List, Tuple
import cv2
import numpy as np
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from pydantic import BaseModel
import cvzone
from cvzone.FaceMeshModule import FaceMeshDetector
import dlib
import time


app = FastAPI()
#cascade_classifier = cv2.CascadeClassifier()


def eye_on_mask(mask, side, shape):
    points = [shape[i] for i in side]
    points = np.array(points, dtype=np.int32)
    mask = cv2.fillConvexPoly(mask, points, 255)
    l = points[0][0]
    t = (points[1][1]+points[2][1])//2
    r = points[3][0]
    b = (points[4][1]+points[5][1])//2
    return mask, [l, t, r, b]

def midpoint(p1 ,p2):
    return int((p1.x + p2.x)/2), int((p1.y + p2.y)/2)

def euclidean_distance(leftx,lefty, rightx, righty):
    return np.sqrt((leftx-rightx)**2 +(lefty-righty)**2)

def get_EAR(eye_points, facial_landmarks):
# Defining the left point of the eye   
    left_point = [facial_landmarks.part(eye_points[0]).x, facial_landmarks.part(eye_points[0]).y]
# Defining the right point of the eye   
    right_point = [facial_landmarks.part(eye_points[3]).x, facial_landmarks.part(eye_points[3]).y]
# Defining the top mid-point of the eye    
    center_top = midpoint(facial_landmarks.part(eye_points[1]), facial_landmarks.part(eye_points[2]))
# Defining the bottom mid-point of the eye   
    center_bottom = midpoint(facial_landmarks.part(eye_points[5]), facial_landmarks.part(eye_points[4]))
 # Calculating length of the horizontal and vertical line    
    hor_line_lenght = euclidean_distance(left_point[0], left_point[1], right_point[0], right_point[1])
    ver_line_lenght = euclidean_distance(center_top[0], center_top[1], center_bottom[0], center_bottom[1])
 # Calculating eye aspect ratio     
    EAR = ver_line_lenght / hor_line_lenght
    return EAR

def find_eyeball_position(end_points, cx, cy):
    """Find and return the eyeball positions, i.e. left or right or top or normal"""
    x_ratio = (end_points[0] - cx)/(cx - end_points[2])
    y_ratio = (cy - end_points[1])/(end_points[3] - cy)
    if x_ratio > 3:
        return 1
    elif x_ratio < 0.33:
        return 2
    elif y_ratio < 0.33:
        return 3
#     elif y_ratio < 0.20:
#         return 5
    else:
        return 0



    
def contouring(thresh, mid, img, end_points, right=False):
    cnts, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_NONE)
    try:
        cnt = max(cnts, key = cv2.contourArea)
        M = cv2.moments(cnt)
        cx = int(M['m10']/M['m00'])
        cy = int(M['m01']/M['m00'])
        if right:
            cx += mid
        cv2.circle(img, (cx, cy), 4, (0, 0, 255), 2)
        
        pos = find_eyeball_position(end_points, cx, cy)
        return pos
    except:
        pass
    
def process_thresh(thresh):
    thresh = cv2.erode(thresh, None, iterations=2) 
    thresh = cv2.dilate(thresh, None, iterations=4) 
    thresh = cv2.medianBlur(thresh, 3) 
    thresh = cv2.bitwise_not(thresh)
    return thresh

def shape_to_np(shape, dtype="int"):
	# initialize the list of (x, y)-coordinates
	coords = np.zeros((68, 2), dtype=dtype)
	# loop over the 68 facial landmarks and convert them
	# to a 2-tuple of (x, y)-coordinates
	for i in range(0, 68):
		coords[i] = (shape.part(i).x, shape.part(i).y)
	# return the list of (x, y)-coordinates
	return coords

def search_word(lis,dic):
    for i in lis:
        
        try :
            if (dic[i]):
                return(dic[i])
        except:
                return 'Not in dict'
        else:
              return "End of text"
    

def print_eye_pos(img, left, right,lis):
    
    #if left == right and left != 0:
        text = ''
        if left == 1:
            print('Looking left')
            text = 'left'
            # lis.append(text)
            
        elif left == 2:
            print('Looking right')
            text = 'right'
            # lis.append(text)
            
        elif left == 3:
            print('Looking up')
            text = 'up'
            # lis.append(text)
        #else:
        #    text='can not detect'
            
            #text='can not detect'

        return text

detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor('shape_predictor_68_face_landmarks.dat')

left = [36, 37, 38, 39, 40, 41]
right = [42, 43, 44, 45, 46, 47]

kernel = np.ones((9, 9), np.uint8)

lis=[]
words=[]

# Creating an object blink_ counter
blink_counter = 0
previous_ratio = 100

class Faces(BaseModel):
    #faces: List[Tuple[int, int, int, int]]
    faces:str


async def receive(websocket: WebSocket, queue: asyncio.Queue):
    bytes = await websocket.receive_bytes()
    
    try:
        queue.put_nowait(bytes)
    except asyncio.QueueFull:
        pass


async def detect(websocket: WebSocket, queue: asyncio.Queue):
    while True:
        bytes = await queue.get()
        data = np.frombuffer(bytes, dtype=np.uint8)
        image = cv2.imdecode(data, 1)
        image = cv2.rotate(image, cv2.ROTATE_90_COUNTERCLOCKWISE)  #this command to rotate image as we recive it from mobile with wide scale . 
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        #faces = cascade_classifier.detectMultiScale(gray)
        
        rects = detector(image, 1)
        word2=''
        for rect in rects:
            shape = predictor(image, rect)
            
            left_eye_ratio = get_EAR([36, 37, 38, 39, 40, 41],shape)
            # Calculating right eye aspect ratio  
            right_eye_ratio = get_EAR([42, 43, 44, 45, 46, 47], shape)

            blinking_ratio = (left_eye_ratio + right_eye_ratio) / 2
            # Rounding blinking_ratio on two decimal places   
            blinking_ratio_1 = blinking_ratio * 100
            blinking_ratio_2 = np.round(blinking_ratio_1)
            blinking_ratio_rounded = blinking_ratio_2 / 100
        # Appending blinking ratio to a list eye_blink_signal
            if blinking_ratio < 0.20:
                if previous_ratio > 0.20:
                        # blink_counter = blink_counter + 1
                        word2 = 'blink'
                        
        # Displaying blink counter and blinking ratio in our output video      

            previous_ratio = blinking_ratio

            shape = shape_to_np(shape)
    #         shape = detect_marks(img, landmark_model, rect)
            mask = np.zeros(image.shape[:2], dtype=np.uint8)
            mask, end_points_left = eye_on_mask(mask, left, shape)
            mask, end_points_right = eye_on_mask(mask, right, shape)
            mask = cv2.dilate(mask, kernel, 5)
            
            eyes = cv2.bitwise_and(image, image, mask=mask)
            mask = (eyes == [0, 0, 0]).all(axis=2)
            eyes[mask] = [255, 255, 255]
            mid = int((shape[42][0] + shape[39][0]) // 2)
            eyes_gray = cv2.cvtColor(eyes, cv2.COLOR_BGR2GRAY)
        # threshold = cv2.getTrackbarPos('threshold', 'image')
            _, thresh = cv2.threshold(eyes_gray, 75, 255, cv2.THRESH_BINARY)
            thresh = process_thresh(thresh)
            
            eyeball_pos_left = contouring(thresh[:, 0:mid], mid, image, end_points_left)
            eyeball_pos_right = contouring(thresh[:, mid:], mid, image, end_points_right, True)
            
            
            dic={'left up right':'hello','left left left':'Breathlessness'
            ,'right right right':'Move','up up up':'Toilet'}

            #if(len(lis)>3): lis=[]
            
            word=print_eye_pos(image, eyeball_pos_left, eyeball_pos_right,lis)
            

            # if(len(word)==3):
            #     words.append(' '.join(word))
            #     print('words =',words)
            #     text=search_word(words,dic)
            #     word.clear()
            #     print(text)
            
            # words.clear()
            aa=Faces(faces=word)
            #await websocket.send_text(aa)
            if(word2!=''):
                bb=Faces(faces=word2)
                await websocket.send_json(bb.dict())
        
            await websocket.send_json(aa.dict())
            


@app.websocket("/blink-to-live")
async def face_detection(websocket: WebSocket):
    await websocket.accept()
    queue: asyncio.Queue = asyncio.Queue(maxsize=10)
    detect_task = asyncio.create_task(detect(websocket, queue))
    try:
        while True:
            await receive(websocket, queue)
    except WebSocketDisconnect:
        detect_task.cancel()
        await websocket.close()


#@app.on_event("startup")
#async def startup():
#    predictor = dlib.shape_predictor(r'E:\my materials\college\the main project\the model\shape_predictor_68_face_landmarks.dat')
    