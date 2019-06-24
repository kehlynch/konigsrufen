// @flow

import React from "react";

import Button from "./Button";
import type { CardType, PlayedCardType } from "../types/card";

type Props = {
  card: CardType | PlayedCardType,
  setSelectedCard?: Function,
  playCard?: Function,
  landscape: boolean,
  selected?: boolean,
  hidden?: boolean,
  small?: boolean
};

const BASE_HEIGHT_VH = 10;
const BASE_WIDTH_VH = BASE_HEIGHT_VH * (50/94)

class Card extends React.Component<Props> {
  getImage() {
    const { card, hidden, landscape } = this.props;
    var path;
    if (hidden && landscape) {
      path = `/static/img/back_landscape.jpg`
    } else if (landscape) {
      path = `/static/img/${card.slug}_landscape.jpg`;
    } else if (hidden) {
      path = `/static/img/back.jpg`
    } else {
      path = `/static/img/${card.slug}.jpg`;
    }
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
    const { card, landscape, selected, small } = this.props;

    var width;
    var height;

    if (landscape) {
      width = small ? BASE_HEIGHT_VH/2 : BASE_HEIGHT_VH;
      height = small ? BASE_WIDTH_VH/2 : BASE_WIDTH_VH;
    } else {
      width = small ? BASE_WIDTH_VH/2 : BASE_WIDTH_VH;
      height = small ? BASE_HEIGHT_VH/2 : BASE_HEIGHT_VH;
    }

    return (
      <div className={`card ${selected ? "selected" : ""}`}>
        <style jsx>{`
          .card {
            width: ${width}vh;
            height: ${height}vh;
          }
          .card.selected {
            width: ${width * 2}vh;
            height: ${height * 2}vh;
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
            border-color: ${!card.legal && selected ? "red" : "black"};
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
          className={`image ${selected ? "selected" : ""}`}
          id={card.slug}
          onClick={this.select}
        />
        {selected && (
          <div className="play">
            <Button text="play" onClick={this.play} type="play" disabled={!card.legal} small />
          </div>
        )}
      </div>
    );
  }
}

export default Card;
