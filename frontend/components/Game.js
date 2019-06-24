// @flow

import React from "react";
import Router from "next/router";

import Board from "./board/Board";
import Hand from "./Hand";
import HiddenHand from "./HiddenHand";
import Menu from "./Menu";
import ScoreBoard from "./ScoreBoard";

import mediaQueries from "../lib/mediaQueries";

import type { GameType } from "../types/game";
import type { HandType } from "../types/hand";
import type { CardType } from "../types/card";

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
      card: null,
      selectedCard: null
    };
  }

  setGame = (game: GameType) => {
    console.log("setGame", game);
    const newUrl = {
      pathname: "/main",
      query: {
        game_id: game.id
      },
      shallow: true
    };

    const href = `/main?game_id=${game.id}`;
    const as = href;

    console.log("setting state...")
    this.setState((state: State) => {
        return {
          ...state,
          game: game
        };
      },
      () => {
        console.log("router replace");
        Router.replace(href, as, { shallow: true });
      }
    );

      // this.setState((state: State) => {
      //   const { response } = state;
      //   const newResponse = {
      //     slug: area.slug,
      //     response_type: "area",
      //     options: response.options,
      //     text: response.text
      //   };

      //   newResponse[field] = fieldValue;
      //   return {
      //     ...state,
      //     response: newResponse
      //   };
      // }, this.submitResponseIfSelect);
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

  renderHand(hand: HandType) {
    const { game, selectedCard } = this.state;

    return (
      <Hand
        hand={hand}
        gameId={game.id}
        setGame={this.setGame}
        setMessage={this.setMessage}
        setSelectedCard={this.setSelectedCard}
        selectedCard={selectedCard}
      />
    );
  }

  renderHiddenHand(hand: HandType, position: string) {
    return <HiddenHand hand={hand} position={position} />;
  }

  render() {
    console.log("render Game", this.props, this.state);
    const { game, message } = this.state;
    const { scoresList, finished } = game;
    const { hands } = game;
    const { p1, p2, p3, p4 } = hands;

    return (
      <div className="game" onClick={this.removeSelection}>
        <style jsx>{`
          .game {
            // margin: 50px;
            display: flex;
            flex-direction: row;
            align-items: space-between;
          }
          .menuContainer {
            flex: 1;
            display: flex;
            flex-direction: column;
          }
          .mainContainer {
            display: flex;
            flex-direction: column;
            flex: 3;
          }
          .scoresContainer {
            flex: 1;
          }
          .n, .s {
            display: flex;
            flex-direction: row;
            justify-content: center;
          }
          .n {
            height: 20vh;
          }
          .s {
            height: 30vh;
          }
          .ew {
            flex: 3;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
          }
          .w {
            display: flex;
            flex-direction: row;
            justify-content: center;
          }
          @media ${mediaQueries.gtSmall} {
          }
        `}</style>
        <div className="menuContainer">
          <Menu setGame={this.setGame} game={game} message={message} />
        </div>
        <div className="mainContainer">
          <div className="n">
            {this.renderHiddenHand(p3, "n")}
          </div>
          <div className="ew">
            <div className="w">{this.renderHiddenHand(p4, "w")}</div>
            <Board game={game} />
            <div className="e">{this.renderHiddenHand(p2, "e")}</div>
          </div>
          <div className="s">{this.renderHand(p1)}</div>
        </div>
        <div className="scoresContainer">
          {finished && <ScoreBoard scoresList={scoresList} />}
        </div>
      </div>
    );
  }
}

export default Game;
