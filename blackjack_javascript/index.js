function addCss(fileName) {
  const head = document.head;
  const link = document.createElement("link");

  link.type = "text/css";
  link.rel = "stylesheet";
  link.href = fileName;

  head.appendChild(link);
}

addCss('https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css');

const suits = ['spades', 'hearts', 'diamonds', 'clubs'];
const values = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'];

function getDeck() {
  const deck = new Array();

  for (var i = 0; i < suits.length; i++) {
    for (var x = 0; x < values.length; x++) {
      let card = { Value: values[x], Suit: suits[i]};
      deck.push(card);
    }
  }
  return deck;
}

const body = document.querySelector('body');
const container = document.createElement('div');
container.className = 'container ui';
body.appendChild(container);
const playBtn = document.createElement('BUTTON');
playBtn.className = 'ui button';
playBtn.innerHTML = "Shuffle & Deal";
container.appendChild(playBtn);

playBtn.addEventListener('click', () => {
  shuffle(getDeck());
});

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
  const hitBtn = document.createElement('BUTTON');
  hitBtn.className = 'hit button ui';
  hitBtn.innerHTML = 'HIT';
  const holdBtn = document.createElement('BUTTON');
  holdBtn.className = 'hold button ui';
  holdBtn.innerHTML = 'HOLD';

  container.appendChild(hitBtn);
  container.appendChild(holdBtn);
  addEventHandlers(hitBtn, holdBtn, deck);
}

function renderDeal(deck) {
  container.innerHTML = '';
  const dealerContainer = document.createElement('div');
  dealerContainer.className = 'dealer_container';
  dealerContainer.innerHTML = 'Dealer: ';
  container.appendChild(dealerContainer);
  const playerContainer = document.createElement('div');
  playerContainer.className = 'player_container';
  playerContainer.innerHTML = 'Player:';
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
  cardTwo = deck.shift();

  addCard(cardOne, dealerContainer);
  addCard(cardTwo, dealerContainer);
}

function addCard(cardInfo, container) {
    const card = document.createElement('div');
    const value = document.createElement('div');
    const suit = document.createElement('div');
    card.className = 'ui card';
    value.className = 'value';
    suit.className = 'suit ' + cardInfo.Suit;
    suit.innerHTML = cardInfo.Suit;
    value.innerHTML = cardInfo.Value;
    card.appendChild(value);
    card.appendChild(suit);
    container.appendChild(card);

    addScore(cardInfo.Value, container);
}

function addEventHandlers(hitBtn, holdBtn, deck) {
  hitBtn.addEventListener('click', () => {
    const card = deck.shift();
    addCard(card, document.querySelector('.player_container'))
  });

  holdBtn.addEventListener('click', () => {
    //hold
    console.log('will hold, thus the dealer goes and math is done');
  });
}

function addScore(value, container) {

}
