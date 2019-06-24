// @flow

import React from "react";

import Card from "./Card";
import { postResponse } from "../lib/response";
import type { CardListType, CardType } from "../types/card";
import type { HandType } from "../types/hand";

type Props = {
  hand: HandType,
  gameId: number,
  setGame: Function,
  setMessage: Function,
  setSelectedCard: Function,
  selectedCard: ?CardType
};

class Hand extends React.Component<Props> {
  playCard = async (card: CardType) => {
    const { gameId, setGame, setMessage } = this.props;

    try {
      const { game, message } = await postResponse(null, card, gameId);

      setGame(game);
      setMessage(message);
    } catch (error) {}
  };

  render() {
    const { hand, setSelectedCard, selectedCard } = this.props;
    const { trumps, spades, hearts, clubs, diamonds } = hand;

    const suits = [trumps, spades, hearts, clubs, diamonds].filter(
      s => s.length > 0
    );

    return (
      <div className={`hand`}>
        <style jsx>{`
          .hand {
            display: flex;
            flex-direction: row;
            margin-top: 75px;
          }
          .suit {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-right: 5px;
            margin-left: 5px;
          }
          .cardContainer {
            margin-top: -55px;
          }
        `}</style>
        {suits.map((cardlist: CardListType, i: number) => (
          <div className={`suit`} key={i}>
            {cardlist.map(card => (
              <div className={`cardContainer`} key={card.slug}>
                <Card
                  card={card}
                  playCard={this.playCard}
                  setSelectedCard={setSelectedCard}
                  selected={selectedCard === card}
                />
              </div>
            ))}
          </div>
        ))}
      </div>
    );
  }
}

export default Hand;
