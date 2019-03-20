//paste in console of about:blank
function init(){
  const BODY = qs('body');
  const container = createElement('div', 'container ui');
  const BTN_CONTAINER = createElement('div', 'ui button_container');
  const playBtn = createElement('BUTTON',  'ui button', "Shuffle & Deal");

  const loseBustMessage = 'YOU LOSE: You went over 21 and busted!';
  const loseToDealerMessage = 'YOU LOSE: Dealer hand wins';
  const winMessage = 'YOU WIN: Dealer went over 21 and busted!';

  let dealerScore = 0;
  let playerScore = 0;
  let playerScoreAlternative = 0;
  let dealerScoreAlternative = 0;

  function qs(element) {
    return document.querySelector(element);
  }

  function createElement(elm, classToAdd = '', textToAdd = '') {
    const element = document.createElement(elm);
    element.className = classToAdd;
    element.innerHTML = textToAdd;

    return element;
  }

  BODY.appendChild(container);
  container.appendChild(playBtn);
  addCss('https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css');

  function addCss(fileName) {
    const head = document.head;
    const link = document.createElement("link");

    link.type = "text/css";
    link.rel = "stylesheet";
    link.href = fileName;

    head.appendChild(link);
  }

  playBtn.addEventListener('click', () => {
    shuffle(getDeck());
  });

  function getDeck() {
    const suits = ['spades', 'hearts', 'diamonds', 'clubs'];
    const values = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'];
    const realValue = [[1, 11], 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10];
    const deck = new Array();

    for (var i = 0; i < suits.length; i++) {
      for (var x = 0; x < values.length; x++) {
        let card = { Value: values[x], Suit: suits[i], RealValue: realValue[x]};
        deck.push(card);
      }
    }
    console.table(deck);
    return deck;
  }

  function shuffle(deck) {
    for (let i = 0; i < 1000; i++) {
      const location1 = Math.floor((Math.random() * deck.length));
      const location2 = Math.floor((Math.random() * deck.length));
      const tmp = deck[location1];

      deck[location1] = deck[location2];
      deck[location2] = tmp;
    }

    renderDeal(deck);
    addPlayerButtons(deck);
  }

  function addPlayerButtons(deck) {
    const hitBtn = createElement('BUTTON', 'hit button ui', 'HIT');
    const holdBtn = createElement('BUTTON', 'hold button ui', 'HOLD');

    container.appendChild(BTN_CONTAINER);
    BTN_CONTAINER.appendChild(hitBtn);
    BTN_CONTAINER.appendChild(holdBtn);

    addEventHandlers(hitBtn, holdBtn, deck);
  }

  function renderDeal(deck) {
    container.innerHTML = '';
    const dealerContainer = createElement('div', 'dealer_container',  'Dealer:');
    const playerContainer = createElement('div', 'player_container', 'Player:');

    container.appendChild(dealerContainer);
    container.appendChild(playerContainer);

    addDealersHand(deck, dealerContainer);
    addPlayersHand(deck, playerContainer);
  }

  function addPlayersHand(deck, playerContainer) {
    cardOne = deck.shift();
    cardTwo = deck.shift();

    addCard(cardOne, playerContainer);
    addCard(cardTwo, playerContainer);
  }

  function addDealersHand(deck, dealerContainer) {
    cardOne = deck.shift();

    addCard(cardOne, dealerContainer);
  }

  function addCard(cardInfo, container) {
    const card = createElement('div', 'ui card');
    const value = createElement('div', 'value', cardInfo.Value);
    const suit = createElement('div', 'suit ' + cardInfo.Suit, cardInfo.Suit);

    card.appendChild(value);
    card.appendChild(suit);

    container.appendChild(card);

    // pointValue = getCardPointValue(cardInfo.Value)
    addScore(cardInfo.Value, container);
  }

  function addEventHandlers(hitBtn, holdBtn, deck) {
    hitBtn.addEventListener('click', () => {
      const card = deck.shift();
      addCard(card, qs('.player_container'));
    });

    holdBtn.addEventListener('click', () => {
      playDealersHand(deck);
    });
  }

  function playDealersHand(deck) {
    newCard = deck.shift();
    addCard(newCard, qs('.dealer_container'));

    checkOverallScores(deck);
  }

  // function getCardPointValue(cardValue) {
  //   let value;
  //
  //   if (cardValue === 'J' || cardValue === 'Q' || cardValue === 'K') {
  //     value = 10;
  //   } else if (cardValue === 'A') {
  //
  //   } else {
  //     value = parseInt(cardValue)
  //   }
  //
  //   return value;
  // }

  function addScore(value, container) {
    if (value === 'J' || value === 'Q' || value === 'K') {
       value = '10';
     }

    if (container.classList.contains('player_container')) {
      if (value === 'A') {
        playerScore += 11;
        //account for two aces...when adding 11 will bust, just add one.
        playerScoreAlternative += 1;
      } else {
        playerScore += parseInt(value);
        playerScoreAlternative += parseInt(value);
      }
    }



    if (container.classList.contains('dealer_container')) {
      if (value === 'A') {
        dealerScore += parseInt('11');
        dealerScoreAlternative += parseInt('1');
      } else {
        dealerScore += parseInt(value);
        dealerScoreAlternative += parseInt(value);
      }
    }

    checkPlayerScores();
  }

  function checkPlayerScores() {
    if (playerScore > 21) {
      if (playerScoreAlternative > 21) {
        addLoseByBust();
        addStartOverBtn();
      }
    }
    console.log('playerScore', playerScore);
    console.log('playerScoreALT', playerScoreAlternative);
    console.log('dealerScore', dealerScore);
    console.log('dealerScoreALT', dealerScoreAlternative);
  }

  function checkOverallScores(deck) {
    if (playerScore > 21) playerScore = playerScoreAlternative;

    if (dealerScore > 21) {
      dealerScore = dealerScoreAlternative;
    }

    if (dealerScore > 21) {
      addWinByDealerBust();
      addStartOverBtn();
    } else if (dealerScore < 16 || dealerScore < playerScore) {
      playDealersHand(deck);
    } else {
      addLoseToDealerMessage();
      addStartOverBtn();
    }
  }

  function addLoseByBust() {
    addGameEndingMessage(loseBustMessage);
  }

  function addLoseToDealerMessage() {
    addGameEndingMessage(loseToDealerMessage);
  }

  function addWinByDealerBust() {
    addGameEndingMessage(winMessage);
  }

  function addGameEndingMessage(message) {
    const bustMessaging = createElement('div', '', message);
    BTN_CONTAINER.parentNode.replaceChild(bustMessaging, BTN_CONTAINER);
  }

  function addStartOverBtn() {
    const restartBtn = createElement('BUTTON', 'ui button', 'REPLAY');

    container.appendChild(restartBtn);

    restartBtn.addEventListener('click', () => {
      container.parentNode.removeChild(container);
      init();
    })
  }
};

init();
