$( document ).ready(function() {
    let voices = [];
    const synth = window.speechSynthesis;
    const cards = document.querySelector('#cards');
    const home = document.querySelector('#home');
    const homeButton = document.querySelector('.navbar-brand');
  
    populateVoiceList();
    if (cards) {
      bindButton();
    }
  
    if (home) {
      bindSetboxButton();
    }
  
    if (homeButton) {
      homeButton.addEventListener('mousedown', () => {
        window.setTimeout(() => bindSetboxButton(), 1000);
      }, false);
    }
  
    if (speechSynthesis.onvoiceschanged !== undefined) {
      speechSynthesis.onvoiceschanged = populateVoiceList;
    }
    
    function populateVoiceList() {
      voices = synth.getVoices().sort(function (a, b) {
          const aname = a.name.toUpperCase(), bname = b.name.toUpperCase();
          if ( aname < bname ) return -1;
          else if ( aname == bname ) return 0;
          else return +1;
      });
    }
  
    function speak(targetLang, targetSpeaker, inputTxt){
        if (synth.speaking) {
            console.error('speechSynthesis.speaking');
            return;
        }
        
        if (inputTxt !== '') {
          var utterThis = new SpeechSynthesisUtterance(inputTxt);
          utterThis.onend = function (event) {
              console.log('SpeechSynthesisUtterance.onend');
          }
          utterThis.onerror = function (event) {
            
              console.error('SpeechSynthesisUtterance.onerror');
          }
    
          utterThis.voice = voices.filter(({ lang, name }) => lang === targetLang && name === targetSpeaker)[0];
    
          synth.speak(utterThis);
      }
    }
    
    function bindButton() {
      document.querySelectorAll('.chinese').forEach((btn, index) => {
        btn.addEventListener('click', (event) => {
          const id = event.target.value;
          const value = document.querySelector(`#chinese-${id}`).innerText;
          speak('zh-TW', 'Mei-Jia', value);
        }, false);
      })
    
      document.querySelectorAll('.english').forEach((btn, index) => {
        btn.addEventListener('click', (event) => {
          const id = event.target.value;
          const value = document.querySelector(`#english-${id}`).innerText;
          speak('en-US', 'Alex', value);
        }, false);
      })
    }
    
    function bindSetboxButton() {
      document.querySelector('.setbox') || document.querySelector('.setbox').addEventListener('mousedown', () => {
        window.setTimeout(() => bindButton(), 1000);
      }, false);
    }
  });
  
  