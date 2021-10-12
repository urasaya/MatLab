 %% Lab 5: Study the algorithm for recognizing text using 
 % optical character recognition (OCR)
 
 % Read image
 OCRimage = imread('OCR_image.jpeg');
 % Show input image
 figure; imshow(OCRimage);
 
 % Returns an ocrText object containing optical character recognition 
% information from the input image
ocrResults = ocr(OCRimage); 
word = ocrResults.Words;
position = ocrResults.WordBoundingBoxes;

% Shows recognition texts in the white box
Iocr = insertObjectAnnotation(OCRimage,'rectangle', ...
                           position, ...
                           word);
figure; imshow(Iocr);
 
     