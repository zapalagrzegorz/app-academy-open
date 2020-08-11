// 1
window.setTimeout(()=>{
  alert('Hammertime');
}, 5000);

// 2
const time = Date();

function hammerTime(time) {

  window.setTimeout(()=> {
    alert(`${time} is Hammertime`);
  }, 5000);
  
}

hammerTime(time);

