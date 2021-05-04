export const getTodos = $.ajax({
  method: 'GET',
  url: '/api/todos',
});
// window.getTodos = getTodos;

// $.ajax({
//   method: 'POST',
//   url: '/api/todos',
//   data: {
//     // :title, :body, :done
//   },
// }).then(
//   (todos) => console.log(todos),
//   (error) => console.log(error)
// );

// $.ajax({
//   method: 'POST',
//   url: '/api/todos',
//   data: {
//     todo: {
//       title: 'a new todo',
//       body: 'expanded body',
//       done: false,
//     },
//   },
// }).then(
//   (todos) => console.log(todos),
//   (error) => console.log(error)
// );

// $.ajax({
//   method: 'PATCH',
//   url: '/api/todos/22',
//   data: {
//     todo: {
//       title: 'an updated new todo',
//     },
//   },
// }).then(
//   (todos) => console.log(todos),
//   (error) => console.log(error)
// );
