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
  selectedCard: ?CardType,
  position: string
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
    const { hand, setSelectedCard, position, selectedCard } = this.props;
    const { trumps, spades, hearts, clubs, diamonds } = hand;

    const suits = [trumps, spades, hearts, clubs, diamonds].filter(
      s => s.length > 0
    );

    return (
      <div className={`hand ${position}`}>
        <style jsx>{`
          .hand {
            display: flex;
            flex-direction: row;
          }
          .hand.s {
            margin-top: 75px;
          }
          .suit {
            display: flex;
            flex-direction: column;
            align-items: center;
          }
          .suit.s {
            margin-right: 5px;
            margin-left: 5px;
          }
          .cardContainer.s {
            margin-top: -75px;
          }
        `}</style>
        {suits.map((cardlist: CardListType, i: number) => (
          <div className={`suit ${position}`} key={i}>
            {cardlist.map(card => (
              <div className={`cardContainer ${position}`} key={card.slug}>
                <Card
                  card={card}
                  playCard={this.playCard}
                  setSelectedCard={setSelectedCard}
                  selected={selectedCard === card}
                  position={position}
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
