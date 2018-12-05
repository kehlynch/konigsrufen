// @flow

import React from "react";

import Header from "./Header";
import Hand from "./Hand";
import HiddenHand from "./HiddenHand";
import Board from "./Board";
import mediaQueries from "../lib/mediaQueries";

import type { GameType } from "../types/game";
import type { HandType } from "../types/hand";
import type { CardType } from "../types/card";
import { EMPTY_CARD } from "../types/card";

type State = {
  game: GameType,
  message: ?string,
  selectedCard: ?CardType
};

type Props = {
  game: GameType
};

class Game extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      game: props.game,
      message: null,
      card: EMPTY_CARD,
      selectedCard: null
    };
  }

  setGame = (game: GameType) => {
    this.setState((state: State) => ({
      ...state,
      game: game
    }));
  };

  setMessage = (message: string) => {
    this.setState((state: State) => ({
      ...state,
      message: message
    }));
  };

  setSelectedCard = (card: CardType) => {
    this.setState((state: State) => ({
      ...state,
      selectedCard: card
    }));
  };

  removeSelection = (card: CardType) => {
    this.setState((state: State) => ({
      ...state,
      selectedCard: null
    }));
  };

  renderHand(hand: HandType, position: string) {
    const { game, selectedCard } = this.state;

    return (
      <Hand
        hand={hand}
        gameId={game.id}
        setGame={this.setGame}
        setMessage={this.setMessage}
        setSelectedCard={this.setSelectedCard}
        selectedCard={selectedCard}
        position={position}
      />
    );
  }

  renderHiddenHand(hand: HandType, position: string) {
    return <HiddenHand hand={hand} position={position} />;
  }

  render() {
    const { game, message } = this.state;
    const { hands, talon, trick } = game;
    const { p1, p2, p3, p4 } = hands;

    console.log(game.trick);

    return (
      <div className="game" onClick={this.removeSelection}>
        <style jsx>{`
          .game {
            margin: 50px;
          }
          .p4 {
            display: flex;
            flex-direction: row;
            justify-content: center;
          }
          .p23 {
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
          }
          .p3 {
            flex-direction: row;
          }
          .p2 {
            flex-direction: row;
          }
          .p1 {
            display: flex;
            flex-direction: row;
            justify-content: center;
          }
          @media ${mediaQueries.gtSmall} {
          }
        `}</style>
        <Header game={game} message={message} />
        <div className="p4">{this.renderHiddenHand(p4, "n")}</div>
        <div className="p23">
          <div className="p3">{this.renderHiddenHand(p3, "w")}</div>
          <Board trick={trick} talon={talon} />
          <div className="p2">{this.renderHiddenHand(p2, "e")}</div>
        </div>
        <div className="p1">{this.renderHand(p1, "s")}</div>
      </div>
    );
  }
}

export default Game;
