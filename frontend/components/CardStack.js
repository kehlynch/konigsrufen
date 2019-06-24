// @flow

import React from "react";

import Card from "./Card";
import type { CardListType, CardType } from "../types/card";

type Props = {
  cards: CardListType,
  playCard?: Function,
  setSelectedCard?: Function,
  rotation?: number,
  selectedCard?: CardType
};

class CardStack extends React.Component<Props> {
  render() {
    const { cards, playCard, rotation, setSelectedCard, selectedCard  } = this.props;

    return (
      <div className={`cardstack ${rotation}`}>
        <style jsx>{`
          .cardstack {
            display: flex;
            flex-direction: column-reverse;
            margin-top: 45px;
          }
          .cardContainer {
            margin-top: -55px;
          }
        `}</style>
          {cards.map(card => (
            <div className="cardContainer" key={card.slug}>
              <Card
                card={card}
                playCard={playCard}
                setSelectedCard={setSelectedCard}
                selected={selectedCard === card}
                small
              />
            </div>
        ))}
      </div>
    );
  }
}

export default CardStack;
