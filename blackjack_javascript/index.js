//paste in console of about:blank
function init(){
  const BODY = qs('body');
  const container = createElement('div', 'container ui');
  const BTN_CONTAINER = createElement('div', 'ui button_container');
  const playBtn = createElement('BUTTON',  'ui button', "Shuffle & Deal");

  const dealerName = 'Dealer';
  const playerName = 'Player';
  const loseBustMessage = `${playerName} LOSES: You went over 21 and busted!`;
  const loseToDealerMessage = `${playerName} LOSES: Dealer hand wins`;
  const winMessage = `${playerName} WINS: Dealer went over 21 and busted!`;

  const playersHand = [];
  const dealersHand = [];

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
    const labels = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'];
    const deck = new Array();

    for (var i = 0; i < suits.length; i++) {
      for (var x = 0; x < labels.length; x++) {
        let card = { Label: labels[x], Suit: suits[i]};
        deck.push(card);
      }
    }

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
    const dealerContainer = createElement('div', 'dealer_container',  `${dealerName}:`);
    const playerContainer = createElement('div', 'player_container', `${playerName}:`);

    container.appendChild(dealerContainer);
    container.appendChild(playerContainer);

    addDealersHand(deck, dealerContainer);
    addPlayersHand(deck, playerContainer);
  }

  function addPlayersHand(deck, playerContainer) {
    dealCard(deck, playerContainer, playersHand);
    dealCard(deck, playerContainer, playersHand);
  }

  function dealCard(deck, container, hand) {
    const card = deck.shift();

    addCard(card, container);
    pushCardToHand(card, hand);
  }

  function addDealersHand(deck, dealerContainer) {
    dealCard(deck, dealerContainer, dealersHand);
  }

  function pushCardToHand(cardInfo, array) {
    array.push(cardInfo.Label);
  }

  function addCard(cardInfo, container) {
    const card = createElement('div', 'ui card');
    const value = createElement('div', 'value', cardInfo.Label);
    const suit = createElement('div', 'suit ' + cardInfo.Suit, cardInfo.Suit);

    card.appendChild(value);
    card.appendChild(suit);

    container.appendChild(card);
  }

  function addEventHandlers(hitBtn, holdBtn, deck) {
    hitBtn.addEventListener('click', () => {
      playersTurn(deck);
    });

    holdBtn.addEventListener('click', () => {
      holdAndPlayDealersTurn(deck);
    });
  }

  function playersTurn(deck) {
    dealCard(deck, qs('.player_container'), playersHand);

    if (checkHandForBust(playersHand)) {
      addLoseByBust();
      addStartOverBtn();
    }
  }

  function holdAndPlayDealersTurn(deck) {
    dealCard(deck, qs('.dealer_container'), dealersHand);

    if (checkHandForBust(dealersHand)) {
      addWinByDealerBust();
      addStartOverBtn();
    } else if (getHandTotal(dealersHand) >= 16){
      compareHands(deck);
    } else {
      holdAndPlayDealersTurn(deck);
    }
  }

  function compareHands(deck) {
    const playersTotal = getHandTotal(playersHand);
    const dealersTotal = getHandTotal(dealersHand);

    if (playersTotal > dealersTotal) {
      holdAndPlayDealersTurn(deck);
    } else {
      addLoseToDealerMessage();
      addStartOverBtn();
    }
  }

  function checkHandForBust(hand) {
    return didPlayerBust(getHandTotal(hand))
  }

  function getHandTotal(hand) {
    let total = 0;
    const points = convertHandLabelsToValuesExceptAce(hand);
    const pointsSorted = points.sort();

    pointsSorted.forEach((pointValue) => {
      if (pointValue === 'A') {
        total += 11;
        if (total > 21) {
          total -= 10;
        }
      } else {
        total += pointValue;
      }
    });

    return total;
  }

  function convertHandLabelsToValuesExceptAce(hand) {
    const points = hand.map((label) => {
      if (label === 'A') {
        return 'A';
      } else if (label === 'J' || label === 'Q' || label === 'K') {
        return 10;
      } else {
        return parseInt(label);
      }
    })

    return points;
  }

  function didPlayerBust(total) {
    if (total > 21) return true;
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
    BTN_CONTAINER.parentNode.replaceChild(bustMessaging, BTN_CONTAINER)
    addFinalScoreMessage();
  }

  function addFinalScoreMessage() {
    const playersTotal = getHandTotal(playersHand);
    const dealersTotal = getHandTotal(dealersHand);
    const messageContainer = createElement('div', 'ui final-container');
    const dealerFinalScoreMessage = createElement('div', 'dealer-score', `${dealerName}: ${dealersTotal}`);
    const playerFinalScoreMessage = createElement('div', 'dealer-score', `${playerName}: ${playersTotal}`);

    messageContainer.appendChild(dealerFinalScoreMessage)
    messageContainer.appendChild(playerFinalScoreMessage)

    container.appendChild(messageContainer)
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
