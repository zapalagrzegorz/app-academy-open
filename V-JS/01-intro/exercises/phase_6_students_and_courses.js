// Instructions
// Write classes to model students and the courses they can enroll in.

// Student class
// Student - a constructor function which should take a first and last name, and set both of those as attributes. It should also set a courses attribute to an empty array.
// Student.prototype.name - returns the concatenation of the student's first and last name
// Student.prototype.enroll - receives Course object, adds it to the student's list of courses, and updates the Course's list of enrolled students
// enroll should ignore attempts to re-enroll a student
// Student.prototype.courseLoad - returns a hash of departments to number of credits the student is taking in that department

function Student(name, lastName) {
  this.name = name;
  this.lastName = lastName;
  this.courses = [];
}

Student.prototype.name = function () {
  return `${this.name} ${this.lastName}`;
};

Student.prototype.enroll = function (course) {
  //  if (!this.courses.includes(course)) {
  try {
    this.hasConflict(course);
    this.courses.push(course);
    course.students.push(this);
  } catch (err) {
    console.error(err.name, err.message, err.lineNumber,);
  }
};

// Student.prototype.courseLoad - returns a hash of departments to number of credits the student is taking in that department
Student.prototype.courseLoad = function () {
  const courseLoad = {};
  // return 
  this.courses.forEach(course =>{
    // intializse
    courseLoad[course.department] = courseLoad[course.department] || 0;
    courseLoad[course.department] += course.credits;
  }); 
};



// Course class
// Course, a constructor function which should take the course name, department, and number of credits. It should also initialize students attribute to an empty array.
// Course.prototype.addStudent should add a student to the class
// Probably can rely upon Student.prototype.enroll

function Course(name, department, credits, dayWeek, blockNum) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.students = [];
  this.dayWeek = dayWeek;
  this.blockNum = blockNum;
}

Course.prototype.addStudent = function (student) {
  student.enroll(this);
};

// Overlapping Courses
// Each course should also take a set of days of the week ('mon', 'tue', ...), plus a time block (assume each day is broken into 8 consecutive time blocks). So a course could meet ['mon', 'wed', 'fri'] during block #1.
// Update your constructor function to also take a time block and days of the week
// Write a method Course.prototype.conflictsWith which takes a second Course and returns true if they conflict

Course.prototype.conflictsWith = function (course) {
  return this.dayWeek.some((day) =>
    course.dayWeek.includes(day) && course.blockNum == this.blockNum
  );

};

// Course.prototype.conflictsWith = function (other) {
//   if (this.block !== other.block) { return false; }

//   return this.days.some(day => other.days.indexOf(day) !== -1 );
// };

const algebra = new Course('Algebra', 'Math', 10, ['mon', 'tue'], 2);
const geometry = new Course('Geometry', 'Math', 9, ['tue', 'fri'], 2);





Student.prototype.hasConflict = function (course) {
  const conflictingCourse = this.courses.some((studentCourse) => studentCourse.conflictsWith(course));

  if (conflictingCourse) {
    throw new Error(`${course.name} conflicts with ${conflictingCourse.name}`);
  }
};

const student = new Student('Grisha', 'Zapala');
// console.log(algebra.conflictsWith(geometry));
student.enroll(algebra);
student.enroll(geometry);


// Update Student.prototype.enroll so that an error is raised if a Student enrolls in a course that conflicts with an existing course time
// Write a Student.prototype.hasConflict helper method
// Recap
// Though we will be relying on Rails for most of our data modeling going forward, there are times when model logic is best handled on the frontend. In this case we may find it beneficial to use OOP to aid us in that abstraction.

// // Student.prototype.courseLoad = function () {
//   const courseLoad = {};

//   this.courses.forEach(course => {
//     let dpt = course.department;
//     courseLoad[dpt] = courseLoad[dpt] || 0;
//     courseLoad[dpt] += course.credits;
//   });

//   return courseLoad;
// };