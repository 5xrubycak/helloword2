let voices;
document.addEventListener("turbolinks:load", function() {
  voices = window.speechSynthesis.getVoices(); 

  if (speechSynthesis.onvoiceschanged !== undefined) {
    speechSynthesis.onvoiceschanged = () => {
      voices = window.speechSynthesis.getVoices();
    };
  };

  if (document.querySelector('#cards')) {
    bindButton();
  }
});

function speak(targetLang, targetSpeaker, inputTxt){
  if (inputTxt !== '') {
    var utterThis = new SpeechSynthesisUtterance(inputTxt);
    utterThis.onend = function (event) {
      console.log('SpeechSynthesisUtterance.onend');
    }
    utterThis.onerror = function (event) {
      console.error('SpeechSynthesisUtterance.onerror');
    }

    utterThis.voice = voices.filter(({ lang, name }) => lang === targetLang && name === targetSpeaker)[0];

    window.speechSynthesis.speak(utterThis);
  }
}
  
function bindButton() {
  document.querySelectorAll('.chinese').forEach((btn, index) => {
    btn.addEventListener('click', (event) => {
      const id = event.target.tagName.toLowerCase() != 'button' ? event.target.parentNode.value : event.target.value;
      const value = document.querySelector(`#chinese-${id}`).innerText;
      speak('zh-TW', 'Mei-Jia', value);
    }, false);
  })

  document.querySelectorAll('.english').forEach((btn, index) => {
    btn.addEventListener('click', (event) => {
      const id = event.target.tagName.toLowerCase() != 'button' ? event.target.parentNode.value : event.target.value;
      const value = document.querySelector(`#english-${id}`).innerText;
      speak('en-US', 'Alex', value);
  }, false);
  })
}  
