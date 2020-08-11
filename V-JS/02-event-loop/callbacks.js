class Clock {
  constructor() {
    const date = new Date();
    this.seconds = date.getSeconds();
    this.minutes = date.getMinutes();
    this.hours = date.getHours();
    // 1. Create a Date object.
    // 2. Store the hours, minutes, and seconds.
    // 3. Call printTime.
    // 4. Schedule the tick at 1 second intervals.
    this.printTime();
    setInterval(()=>{
      this._tick();
    }, 1000);
    // w ten sposób this będzie usyawiony na obiekt (funkcję) Timeout
    // setInterval(this._tick, 1000);
  }

  printTime() {
    // this.seconds
    console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
    // Format the time in HH:MM:SS
    // Use console.log to print it.
  }

  _tick() {

    this.seconds += 1;
    this.printTime();
    // 1. Increment the time by one second.
    // 2. Call printTime.
  }
}

const clock = new Clock();