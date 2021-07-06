
class LapManager{
  List<Lap> laps = [];
  int shortestLap = -1;
  int longestLap = -1;

  LapManager();

  void addLap(Lap lap){


    int previousTotalLapTime = 0;
    if(this.laps.length > 0){
      previousTotalLapTime = this.laps[this.laps.length-1].totalTime;
    }
    int currentLapTime = lap.totalTime - previousTotalLapTime;


    Lap currentLap = Lap(currentLapTime, lap.totalTime);


    this.laps.add(currentLap);

    int minIndex = 0, minTime = lap.lapTime, maxIndex = 0, maxTime = lap.lapTime;

    for(int i = 0; i < this.laps.length; i++){
      if(this.laps[i].lapTime <= minTime){
        minTime = this.laps[i].lapTime;
        minIndex = i;
      }
      if(this.laps[i].lapTime >= maxTime){
        maxTime = this.laps[i].lapTime;
        maxIndex = i;
      }
    }

    print('herer3');

    this.shortestLap = minIndex;
    this.longestLap = maxIndex;
  }

  void clearLaps(){
    this.laps = [];
    this.shortestLap = -1;
    this.longestLap = -1;
  }


}

class Lap{
  int lapTime;
  int totalTime;

  Lap(this.lapTime, this.totalTime);

  Lap.from(int totalTime):
    this.lapTime = -1,
    this.totalTime = totalTime;
  
}