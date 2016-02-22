/***********************************************************************
   ***********************************************************************
   **                                                                   **
   **                              HI!!                                 **
   **                                                                   **
   ***********************************************************************
   ***********************************************************************



*/



/**********************************************
*                                            *
*                    INTRO                   *
*                                            *
**********************************************



  */
//put the number of image sets here
int numSets = 3;


PImage[] img= new PImage[30]  ;  // Declare variable "a" of type PImage
int step;
int testNum=1;
int imageRight;
int imageLeft;
int sampelImage;
int randImage;
int nTest=0;
String subjectNum = "";
String subjectAge = "";
int subjectGen = 0;
boolean subjectInfoSet =false;  
boolean[] corectly= new boolean[20];
float buffer;
float timerT1;
float timeT1;
float timerT2;
float timeT2;  
PrintWriter dataWriter;
import java.io.File;
import java.io.IOException;
  




  /***********************************************************************
   ***********************************************************************
   **                                                                   **
   **                THE TWO MOST IMPORTANT METHODS                     **
   **                                                                   **
   ***********************************************************************
   ***********************************************************************



*/

void setup() {
  // frame.setResizable(true);//only in pc will you need this
  //  size(700,400);//only in pc will you need this
  textAlign(CENTER);
  //textSize(95);//on my tablet should be fixed for new device but i have not done it yet
  textSize(60);//on pc
  fill(0);
  loadImages(); // Load the image into the program  
  step = 1;
  String dirName;
  try{
    dirName = "MemData";
    File newFile = new File(dirName);
    newFile.mkdirs();
    if(newFile.exists()) {
      //nothing 
      if(newFile.isDirectory()) {
        //nothing 
      } 
      else {}
    } 
    else {
      println("Directory Doesn't Exist... Creating");
    }
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  dataWriter = createWriter( "//sdcard//MemData/dataON"+month()+"."+day()+"."+year()+"AT"+hour()+":"+minute()+":"+second()+".csv"); //in android//makes header 
  dataWriter.println(" subject.number,subject.age,is.female,test.number,imageLeft,imageRight,sampelImage,randImage,corect.or.not,time.to.pick-t1, time.to.pick-t2 ,time.total");
}


void draw() {
  if( subjectInfoSet ){
    switch (testNum) {
      case 1:  testOne();//obvious method name is obvious
               break;
      case 2:  testTwo();//shows the selection and waits for  input, should be renamed
               break;
      case 3:  testMix();//decide if user was wrong or right 
               break;
      default: error();//I don't know why I needed this
               break;
    }
  }
  else{
    setSubject();
  } 
}


void loadImages(){
// The image file must be in the data f 
  for(int j=0; j<30;j++){
    img[j]=loadImage(j+".jpg");
    
  }
}


/***********************************************************************
***********************************************************************
**                                                                   **
**                       SETUP A NEW USER                            **
**                                                                   **
***********************************************************************
***********************************************************************



*/

/**********************************************
*                                            *
*              ENTER IMAGE SET             *
*                                            *
**********************************************



  */

void setImageSet(){

float lowcom;
  if(width<height){ lowcom =width;}
  else{ lowcom =height;}
  
  background(0); //black background
  float xlok= lowcom * .1;
  float ylok= lowcom * .3;
  textSize(90);
  textAlign(CENTER);
  for(int i=0;i<numSets;i++){
      fill(0, 102, 153);
      rect( i*(width/numSets),0, (i+1)*(width/numSets),height);
      fill(0);
      text("Use Image\nSet\n"+i,(i)*(width/numSets)+(width/numSets)/2,height/2);
  }
}



/**********************************************
*                                            *
*              ENTER USER NUMBER             *
*                                            *
**********************************************



  */

void setSubjectNum(){
  float lowcom;
  if(width<height){ lowcom =width;}
  else{ lowcom =height;}
  background(0); //black background
  float xlok= lowcom * .1;
  float ylok= lowcom * .3;
  int num=9;
  for(int j=0;j<3;j++){
    for(int i=0;i<3;i++){
      fill(0, 102, 153);
      rect( xlok+lowcom*.2*i, ylok+lowcom*.2*j , lowcom *.15, lowcom *.15);
      fill(0);
      text(num, lowcom*.12 +lowcom*.2*i, lowcom*.35 +lowcom*.2*j);
      num--;
    }
  }
  fill(0, 102, 153);
  rect( xlok+lowcom*.2*3, ylok+lowcom*.2*2 , lowcom *.15, lowcom *.15);
  rect( xlok+lowcom*.2*3, ylok , lowcom *.15, lowcom *.35);
  fill(0);
  text(0, lowcom*.12 +lowcom*.2*3, lowcom*.35 +lowcom*.2*2);
  text("DONE", lowcom*.12+ lowcom*.2*3, lowcom*.35 );
  num=9;
  int k=0;
  if(mousePressed && millis()-buffer > 700){
    fill(0, 102, 153);
    //text("k",30,30);
    for(int j=0;j<3;j++){
      for(int i=0;i<3;i++){
        if(mouseX > xlok+lowcom*.2*i && mouseY > ylok+lowcom*.2*j && mouseX < xlok+lowcom*.2*i+lowcom *.15 && mouseY < ylok+lowcom*.2*j +lowcom *.15 ){
          textSize(90);
          subjectNum= subjectNum+num;
          buffer=millis();       
        }
     num--;
     }   
  }
  if(mouseX > xlok+lowcom*.2*3 && mouseY > ylok+lowcom*.2*2 && mouseX < xlok+lowcom*.2*3+lowcom *.15 && mouseY < ylok+lowcom*.2*2 +lowcom *.15 ){
    subjectNum= subjectNum+"0";
    buffer=millis();
  }
  if(mouseX > xlok+lowcom*.2*3 && mouseY > ylok && mouseX < xlok+lowcom*.2*3+lowcom *.15 && mouseY < ylok+lowcom *.35 ){
    //subjectNumSet=true;
    step++;
    fill(0);
    buffer=millis();
  }
  }
  textSize(140);
  fill(0, 102, 153);
  text( "The subject number is ->" + subjectNum , 0, lowcom * .1 );
  //  rect( lowcom *.1, lowcom *.8, lowcom *.15, lowcom *.15);
  textSize(70);
}

/**********************************************
*                                            *
*               ENTER USER AGE               *
*                                            *
**********************************************



*/

void setSubjectAge(){
  float lowcom;
  if(width<height){ lowcom =width;}
  else{ lowcom =height;}
  background(0); //black background
  float xlok= lowcom * .1;
  float ylok= lowcom * .3;
  int num=9;
  for(int j=0;j<3;j++){
    for(int i=0;i<3;i++){
      fill(0, 102, 153);
      rect( xlok+lowcom*.2*i, ylok+lowcom*.2*j , lowcom *.15, lowcom *.15);
      fill(0);
      text(num, lowcom*.12 +lowcom*.2*i, lowcom*.35 +lowcom*.2*j);
      num--;
    }
  }
  fill(0, 102, 153);
  rect( xlok+lowcom*.2*3, ylok+lowcom*.2*2 , lowcom *.15, lowcom *.15);
  rect( xlok+lowcom*.2*3, ylok , lowcom *.15, lowcom *.35);
  fill(0);
  text(0, lowcom*.12 +lowcom*.2*3, lowcom*.35 +lowcom*.2*2);
  text("DONE", lowcom*.12 +lowcom*.2*3 , lowcom*.35 );
  num=9;
  int k=0;
  if(mousePressed && millis()-buffer > 700){
    fill(0, 102, 153);
    //text("k",30,30);
    for(int j=0;j<3;j++){
      for(int i=0;i<3;i++){
        if(mouseX > xlok+lowcom*.2*i && mouseY > ylok+lowcom*.2*j && mouseX < xlok+lowcom*.2*i+lowcom *.15 && mouseY < ylok+lowcom*.2*j +lowcom *.15 ){
          textSize(90);
          subjectAge= subjectAge+num;
          buffer=millis();       
        }
     num--;
     }   
  }
  if(mouseX > xlok+lowcom*.2*3 && mouseY > ylok+lowcom*.2*2 && mouseX < xlok+lowcom*.2*3+lowcom *.15 && mouseY < ylok+lowcom*.2*2 +lowcom *.15 ){
    subjectAge= subjectAge+"0";
    buffer=millis();
  }
  if(mouseX > xlok+lowcom*.2*3 && mouseY > ylok && mouseX < xlok+lowcom*.2*3+lowcom *.15 && mouseY < ylok+lowcom *.35 ){
    //subjectNumSet=true;
    step++;
    fill(0);
    buffer=millis();
  }
  }
  textSize(140);
  fill(0, 102, 153);
  text("The subject age is ->" + subjectAge , 0, lowcom * .1 );
  
  //  rect( lowcom *.1, lowcom *.8, lowcom *.15, lowcom *.15);
  textSize(70);
}

/**********************************************
*                                            *
*              ENTER USER GENDER             *
*                                            *
**********************************************



  */

void setSubjectGen(){
  float lowcom;
  if(width<height){ lowcom =width;}
  else{ lowcom =height;}
  background(0); //black background
  float xlok= lowcom * .1;
  float ylok= lowcom * .3;
  int num=9;
  fill(0, 102, 153);
  rect( 0, 0, width/2 , height);
  fill( #E71539 );
  rect( width/2 , 0, width/2 , height);
  fill(0);
  
  text("Male", width/4 , height/2 );
  text("Female", width*3/4 , height/2 );
  num=9;
  int k=0;
  if(mousePressed && millis()-buffer > 700){
    fill(0, 102, 153);
    //text("k",30,30);
  
  if( mouseX < width/2 ){
    step=1;
    subjectInfoSet=true;
    fill(0);
    buffer=millis();
  }
  if( mouseX > width/2  ){
    subjectGen=1;
    step=1;
    subjectInfoSet=true;
    fill(0);
    buffer=millis();
  }
  }
  textSize(140);
  fill(0, 102, 153);
  text( subjectGen , lowcom * .5 , lowcom * .1 );
  //  rect( lowcom *.1, lowcom *.8, lowcom *.15, lowcom *.15);
  textSize(70);
}

  
  
  
  /***********************************************************************
   ***********************************************************************
   **                                                                   **
   **                       TEST FLOW CONTROL                           **
   **                                                                   **
   ***********************************************************************
   ***********************************************************************



*/


/**********************************************
*                                            *
*            SET UP NEW USER                 *
*                                            *
*********************************************/


void setSubject(){
  switch (step) {
    case 1:  textAlign(LEFT);
             setImageSet();//obvious method name is obvious
             break;
    case 2:  textAlign(LEFT);
             setSubjectNum() ;//obvious method name is obvious
             break;
    case 3:  setSubjectAge() ;//shows the selection an waits for  input, should be renamed
             break;
    case 4:  textAlign(CENTER);
             setSubjectGen() ;//decide if user was wrong or right 
             break;
    default: error();//I don't know why I needed this
             break;
  }
}


/**********************************************
*                                            *
*                   TEST ONE                 *
*                                            *
*********************************************/

void testOne(){ 
  switch (step) {
    case 1:  welcomeOne();//obvious method name is obvious
             break;
    case 2:  displayOne();//shows the selection an waits for  input, should be renamed
             break;
    case 3:  evalOne();//decide if user was wrong or right 
             break;
    case 4:  contin();//decides if the player plays another round 
             break;
    default: error();//I don't know why I needed this
             break;
  }
}

/**********************************************
*                                            *
*                   TEST TWO                 *
*                                            *
*********************************************/

void testTwo(){
   switch (step) {
    case 1:  welcomeTwo();//obvious method name is obvious
             break;
    case 2:  hold();//obvious method name is obvious
             break;
    case 3:  sample(); 
             break;
    case 4:  hold(); 
             break;
    case 5:  select();
             break;
    case 6:  evalTwo();//decide if user was wrong or right 
             break;
    case 7:  if(nTest < 10){nTest++;step=2;}else{testNum=3;step=1;}//decides if the player plays another round 
             break;
    default: error();//I don't know why I needed this
             break;
  } 
}

/**********************************************
*                                            *
*               TEST THREE/MIXED             *
*                                            *
*********************************************/

void testMix(){
  switch (step) {
    case 1:  welcomeThree();//obvious method name is obvious
             break;
    case 2:  hold();
             break;
    case 3:  sample();
             break;
    case 4:  hold();
             break;
    case 5:  hold();  
             break;
    case 6:  displayOne();  
             break;
    case 7:  evalOne();  
             break;
    case 8:  hold();  
             break;
    case 9:  select();  
             break;
    case 10:  evalTwo();  
             break;   
    case 11: endTests();
             break;
    case 12: credits();
             break;
    default: error();//I don't know why I needed this
             break;
  }
}

  /***********************************************************************
   ***********************************************************************
   **                                                                   **
   **                          ALL THE PARTS                            **
   **                             TEST 1                                **
   **                                                                   **
   ***********************************************************************
   **********************************************************************/
   
   
/**********************************************
  *                                            *
  *               WELCOME ONE                  *
  *                                            *
  **********************************************



*/

void welcomeOne(){
  fill(0);
  background(131,165,174);
  //text( basePath ,width/2, height/2 );
  text("Welcome To The Memory Test! \n Touch the screen to begin.",width/2, height/2 );
  if(mousePressed && buffer+100<millis() ){
    step++;
    buffer=millis();
  }
  for(boolean i : corectly){
    i=false;
  }
}

/**********************************************
  *                                            *
  *               DISPLAY ONE                  *
  *                                            *
  **********************************************



*/

void displayOne(){
  imageLeft =int(random(0,19.99));
  boolean boo=boolean(imageLeft%2);
  if(boo){
    imageRight=imageLeft-1;
  }
  else{
    imageRight = imageLeft+1;
  }
  putsImages( imageLeft , imageRight );
  timerT1=millis();
  step++;
}

/**********************************************
  *                                            *
  *              FEEDBACK ONE                  *
  *                                            *
  **********************************************



*/

void feedBack(int choice){
  boolean corect=boolean(choice%2);
  background(131,165,174);
  timeT1 = millis ( ) -timerT1;
  int corectNum = int(corect);
  if(testNum==1){dataWriter.println( subjectNum+","+subjectAge+","+ subjectGen+"," + testNum +","+imageLeft+","+imageRight+","+"<NA>"+","+"<NA>"+"," +corectNum+","+timeT1+","+"<NA>"+","+millis());}
  else{dataWriter.println( subjectNum+","+subjectAge+","+ subjectGen +","+testNum+","+imageLeft+","+imageRight+","+sampelImage+","+randImage+","+corectNum+","+timeT1+","+timeT2+","+millis());}
  if( corect ){
    text("CORRECT", width/2,height/2 );
    corectly[imageRight]=true;
    corectly[imageLeft]=true;
  }
  else{
    text("INCORRECT", width/2,height/2 ); 
    corectly[imageRight]=false;
    corectly[imageLeft]=false;
  }
  buffer=millis();
  step++;
} 

/**********************************************
  *                                            *
  *              EVALUATION TWO                *
  *                                            *
  **********************************************



*/

void evalOne(){
  int choice=0;
  boolean boo;
  if(mousePressed && millis()-buffer > 500 && mouseX > width/1.7){
    //This is the left image or image n
    choice=imageLeft; 
    feedBack(choice);
  }
  if(mousePressed && millis()-buffer > 500 && mouseX < width/2.3){
    //This is the right image or image m
    choice=imageRight;
    feedBack(choice);
  } 
}

/**********************************************
  *                                            *
  *              CONTINUE                *
  *                                            *
  **********************************************



*/

void contin(){
  boolean allCorrect=true;
  for(boolean i : corectly){
    if(i==false){
      allCorrect=false;
      break;
    }
  }
  if(buffer+1000< millis()){
    if(allCorrect){
      testNum=2;
      step=1;
    }
    else{
      step=2;
    }
  }
}

  /***********************************************************************
   ***********************************************************************
   **                                                                   **
   **                          ALL THE PARTS                            **
   **                             TEST 2                                **
   **                                                                   **
   ***********************************************************************
   **********************************************************************/

/**********************************************
  *                                            *
  *               WELCOME TWO                  *
  *                                            *
  **********************************************



*/

void welcomeTwo(){
  background(131,165,174);
  text("Congratulations! \n You have completed the first part of the test.\n touch the screen to continue .", width/2,height/2 );
  if(mousePressed && buffer+100<millis() ){
    step++;
    buffer=millis();
  }
}

/**********************************************
  *                                            *
  *                     SAMPLE                 *
  *                                            *
  **********************************************



*/

void sample(){
  if( buffer+1000< millis()){
    sampelImage=int(random(20,30));
    randImage=sampelImage;
    putsImage(sampelImage);
    step++;
    buffer=millis();
  }  
}

/**********************************************
  *                                            *
  *                     HOLD                   *
  *                                            *
  **********************************************



*/

void hold(){
  if(buffer+1000 < millis()){
    background(131,165,174);
    while(randImage==sampelImage){
      randImage =int(random(20,30));
    }
    buffer=millis();
    step++;
  }  
}
/**********************************************
  *                                            *
  *                 SELECT                     *
  *                                            *
  **********************************************



*/

void select(){
  if( buffer+1000 < millis()){
    boolean boo;
    boo=boolean(int(random(0,2)));
    if(boo){ imageLeft=sampelImage ;imageRight=randImage;}
    else { imageLeft=randImage ; imageRight=sampelImage;}
    putsImages( imageLeft , imageRight );
    buffer=millis();
    timerT2=millis();
    step++;  
  }
}

/**********************************************
  *                                            *
  *              PUT ONE IMAGE                 *
  *                                            *
  **********************************************



*/
void putsImage(int i){
  background(131,165,174);
  image(img[i], width/3, height/4, width/3, width/3 );
}

/**********************************************
  *                                            *
  *              EVALUATION TWO                *
  *                                            *
  **********************************************



*/

void evalTwo(){
  int choice=0;
  if(mousePressed && millis()-buffer > 500 && mouseX > width/1.7){
    //This is the left image or image n
    choice=imageLeft; 
    feedBackTwo(choice);
  }
  if(mousePressed && millis()-buffer > 500 && mouseX < width/2.3){
    //This is the right image or image m
    choice=imageRight;
    feedBackTwo(choice);
  } 
}

/**********************************************
  *                                            *
  *              FEEDBACK TWO                  *
  *                                            *
  **********************************************



*/

void feedBackTwo(int choice){
  boolean corect=false;
  background(131,165,174);
  timeT2 = millis ( ) -timerT2;
  if( choice == sampelImage ){
     text("CORRECT", width/2,height/2 );
     corect=true;
  }
  else{
     text("INCORRECT", width/2,height/2 ); 
  }
  int corectNum = int(corect);
  if(testNum==2){dataWriter.println( subjectNum+","+subjectAge+","+ subjectGen+"," + testNum+","+"<NA>"+","+"<NA>"+","+sampelImage+","+randImage+","+corectNum+","+"<NA>"+","+timeT2+","+millis());}
  else{dataWriter.println( subjectNum+","+subjectAge+","+ subjectGen +","+testNum+","+imageLeft+","+imageRight+","+sampelImage+","+randImage+","+corectNum+","+timeT1+","+timeT2+","+millis());}
  buffer=millis();
  step++;
}

  /***********************************************************************
   ***********************************************************************
   **                                                                   **
   **                          ALL THE PARTS                            **
   **                             TEST 3                                **
   **                                                                   **
   ***********************************************************************
   **********************************************************************/

/**********************************************
  *                                            *
  *               WELCOME TWO                  *
  *                                            *
  **********************************************



*/

void welcomeThree(){
  background(131,165,174);
  text("Congratulations! \n You have completed the second part of the test.\n The next test will commence shortly.", width/2,height/2 );
  dataWriter.flush();  // Writes the remaining data to the file
  //dataWriter.close();  // Finishes the file
  nTest=0;
  if(mousePressed && buffer+100<millis() ){
    step++;
    buffer=millis();
  }
}

  /***********************************************************************
   ***********************************************************************
   **                                                                   **
   **                          ALL THE PARTS                            **
   **                             SHARED                                **
   **                                                                   **
   ***********************************************************************
   **********************************************************************/

/**********************************************
  *                                            *
  *                 PUT TWO IMAGES             *
  *                                            *
  **********************************************



*/

void putsImages(int i, int k){
  background(131,165,174);
  image(img[k], width/16, height/4, width/3, width/3 );
  image(img[i], (9.5 * width)/16, height/4, width/3 , width/3 );
}

/**********************************************
  *                                            *
  *                END THE PROGRAM             *
  *                                            *
  **********************************************



*/

void endTests(){
  if(nTest < 9){nTest++;step=2;}else{
    background(131,165,174);
    text("Congratulations! \n You have completed the test.", width/2,height/2 );
    dataWriter.flush();  // Writes the remaining data to the file
    dataWriter.close();  // Finishes the file
    buffer=millis();
    step++;
  }
}

/**********************************************
  *                                            *
  *         EXTRA NON CRITICAL BITS            *
  *                                            *
  *********************************************/

void credits(){
  if(buffer+3000<millis()){
    text("This Program was writen by Rory Flynn" , width*.5, height * .1 );
  }
}

void error(){
  background(131);
  text("ERROR", width/2,height/2 );
  dataWriter.flush();  // Writes the remaining data to the file
  dataWriter.close();  // Finishes the file
}