import processing.video.*;

int numMovies = 48;//total number of movies
Movie[] playlist = new Movie[numMovies];//a list of all the movie objects, currently not initialized
int currentMovieIndex = 0;//index of the movie currently playing
int loopCount = 0;
int effectChoice = int(random(6));
float xOff = 0.0;

float movieEndDuration = 0.15;//a 'magic number' helpful to find out when a movie finishes playing

void setup(){
  //size(1280,720);
  fullScreen();
  for(int i = 0 ; i < numMovies; i++){
    //initialize each movie object in the list
    playlist[i] = new Movie(this, (i+1)+".mp4");//new Movie(this,"5.mp4");
  }
  //start playback
  playlist[currentMovieIndex].loop();
}

void draw(){
  background(0);
  //apply effect
  switch(effectChoice){
   case 1:
     tint(200,0,0);
     break;
   case 2:
     tint(0,200,0);
     break;
   case 3:
     tint(0,0,200);
     break;
   case 4:
     tint(200,200,0);
     break;
   case 5:
     tint(2005,0,200);
     break;
   case 6:
     tint(0,200,200);
     break;
  }
  image(playlist[currentMovieIndex],0,0);
  tint(255,50);
  xOff += .01;
  //image(playlist[currentMovieIndex],int(noise(xOff)*100),int(noise(xOff)*50));
}

void movieEvent(Movie m){
  m.volume(0);
  m.read();
  //handy for debugging and figuring out the 'magic number'
  println(m.time() + " / " + m.duration() + " / " + (m.time() + movieEndDuration));
  //hacky check movie end 
  if((m.time() + movieEndDuration) >= m.duration()){
      println("movie at index " + currentMovieIndex + " finished playback");
      //add one to the loop and check how many times its played
      loopCount += 1;
      println("loopCount = " + loopCount);
      if(loopCount >= 2){
        loopCount = 0;
        effectChoice = int(random(6));
        //go to a new random movie index
        currentMovieIndex = (int(random(numMovies-1))+1) % numMovies;//increment by one buy use % to loop back to index 0 when the end of the movie array is reached
      }
      //use this to tell the next movie in the list to play
      playlist[currentMovieIndex].loop();
      println("movie at index " + currentMovieIndex + " started");
  }
}