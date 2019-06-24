// @flow

import React from "react";

import Card from "./Card";
import type { CardListType } from "../types/card";
import type { HandType } from "../types/hand";

type Props = {
  hand: HandType,
  position: string
};

const OVERLAP = 25;

class HiddenHand extends React.Component<Props> {
  renderCard(index, card) {
    const { position } = this.props;
    const landscape = position === "e" || position === "w";

    return (
      <div className={`card ${position}`}>
        <style jsx>{`
          .cardContainer.n {
            margin-left: -${OVERLAP}px;
          }
          .cardContainer.e,
          .cardContainer.w {
            margin-top: -${OVERLAP}px;
          }
        `}</style>
        <div className={`cardContainer ${position}`} key={card.slug}>
          <Card key={card.slug} card={card} landscape={landscape} hidden />
        </div>
      </div>
    );

  }
  render() {
    const { hand, position } = this.props;

    const { trumps, spades, hearts, clubs, diamonds } = hand;
    const cards: CardListType = [
      trumps,
      spades,
      hearts,
      clubs,
      diamonds
    ].reduce(function(prev, curr) {
      return prev.concat(curr);
    });

    return (
      <div className={`hand ${position}`}>
        <style jsx>{`
          .hand {
            display: flex;
            margin: 20px;
            width: 10vh;
          }
          .hand.n {
            margin-left: ${OVERLAP}px;
            align-items: flex-end;
            flex-direction: row-reverse;
            justify-content: center;
          }
          .hand.e,
          .hand.w {
            margin-top: ${OVERLAP}px;
          }
          .hand.e {
            flex-direction: column-reverse;
          }
          .hand.w {
            flex-direction: column;
            align-items: center;
            display: flex;
            flex: 1;
          }
        `}</style>
        {cards.map((card, i) => ( this.renderCard(i, card)))}
      </div>
    );
  }
}

export default HiddenHand;
