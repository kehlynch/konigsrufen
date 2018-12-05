// @flow

import React from "react";

import Button from "./Button";
import type { CardType } from "../types/card";

type Props = {
  card: CardType,
  position: string,
  setSelectedCard?: Function,
  playCard?: Function,
  selected?: boolean,
  hidden?: boolean
};

class Card extends React.Component<Props> {
  getImage() {
    const { card, hidden } = this.props;
    const path = hidden
      ? `/static/img/back.jpg`
      : `/static/img/${card.slug}.jpg`;
    return path;
  }

  select = (e: Event) => {
    const { card, setSelectedCard } = this.props;
    e.stopPropagation();
    setSelectedCard && setSelectedCard(card);
  };

  play = (e: Event) => {
    const { card, playCard } = this.props;
    e.stopPropagation();
    playCard && playCard(card);
  };

  render() {
    const { card, position, selected } = this.props;

    return (
      <div className={`card ${position} ${selected ? "selected" : ""}`}>
        <style jsx>{`
          .card {
            width: 50px;
            height: 94px;
          }
          .card.selected {
            width: 100px;
            height: 188px;
            z-index: 10;
            align-items: center;
            display: flex;
            flex-direction: column;
            position: relative;
          }
          
          .image {
            width: 100%;
            height: auto;
            border: 1px solid black;
            border-radius: 5px;
            object-fit: cover;
          }
          .play {
            position: absolute;
            top: 70%;
            left: 50%;
            transform: translate(-50%, -50%);
          }
        `}</style>
        <img
          src={this.getImage()}
          className={`image ${position} ${selected ? "selected" : ""}`}
          id={card.slug}
          onClick={this.select}
        />
        {selected && (
          <div className="play">
            <Button text="play" onClick={this.play} type="play" small />
          </div>
        )}
      </div>
    );
  }
}

export default Card;
