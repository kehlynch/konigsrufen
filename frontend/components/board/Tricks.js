// @flow

import React from "react";

import Card from "../Card";
import Points from "./Points";
import { colours } from "../../lib/theme";
import type { PlayedCardType } from "../../types/card";
import type { TrickType, TricksType } from "../../types/trick";

type Props = {
  tricks: TricksType,
  gameId: number,
  points: PointsType
};

type State = {
  currentTrickIndex: number,
  show: Array<string>,
  showPoints: boolean
};

const DELAY = 500;

class Tricks extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);

    const { tricks } = props;
    const currentTrickIndex = tricks.length - 1;
    const currentTrick = tricks[currentTrickIndex] || [];
    const show = currentTrick.map((c) => c.player);
    this.state = {
      currentTrickIndex: currentTrickIndex,
      show: show,
      showPoints: tricks.length === 12 && tricks[11].length === 4
    };
  }

  componentDidMount(prevProps: Props) {
    console.log("Tricks componentDidMount", this.props, prevProps);
  }

  componentDidUpdate(prevProps: Props) {
    console.log("Tricks componentDidUpdate", this.props, prevProps)
    if (this.props.gameId !== prevProps.gameId) {
      // new game - reset the state
      this.resetState()
    } else if (this.props.tricks !== prevProps.tricks) {
      this.advanceTricks();
    }
  }

  resetState() {
    console.log("resetState", this.props, this.state)
    const { tricks } = this.props;
    const currentTrickIndex = tricks.length - 1;
    const currentTrick = tricks[currentTrickIndex];
    const show = currentTrick ? currentTrick.map((c) => c.player) : [];

    this.setState((state: State) => ({
      show: show,
      currentTrickIndex: currentTrickIndex,
      showPoints: tricks.length === 12 && tricks[11].length === 4
    }))
  }

  advanceTricks() {
    console.log("advanceTricks")
    const { tricks } = this.props;
    const { currentTrickIndex, show } = this.state;
    const cardsToReveal = tricks[currentTrickIndex].length - show.length;
    if ( cardsToReveal > 0 ) {
      this.showTrick(currentTrickIndex, 0, show)
    }

    let index = currentTrickIndex;
    const maxIndex = tricks.length - 1;
    let interval = (cardsToReveal + 1) * DELAY;
    while ( index < maxIndex) {
      index++;
      this.showTrick(index, interval)
      interval = interval + (DELAY * 5);
    }

    if (tricks.length === 12 && tricks[11].length === 4) {
      setTimeout( () => {
        this.setState((state: State) => ({
          ...state,
          showPoints: true
        }));
      }, interval)
    }
  }

  showTrick(trickIndex, interval = 0, shown = []) {
    console.log("showTrick shown", shown);
    const { tricks } = this.props;
    const trick = tricks[trickIndex];

    const newCards = trick.filter(card => !shown.includes(card.player))
    console.log("newCards", newCards)
    newCards.forEach((card: PlayedCardType) => {
      interval = interval + DELAY;
      this.revealCard(card, trickIndex, interval);
    })

    if (trick.length == 4) {
      interval = interval + DELAY;
      setTimeout( () => {
        this.setState((state: State) => ({
          ...state,
          show: [],
          currentTrickIndex: state.currentTrickIndex + 1
        }));
      }, interval)
    }
  }

  revealCard(card: CardType, trickIndex: number, interval: number) {
    console.log("revealCard", trickIndex);
    setTimeout( () => {
      this.setState((state: State) => {
        const show = state.show.length === 4 ? [card.player] : [...state.show, card.player]
        return {...state, currentTrickIndex: trickIndex, show: show}
      });
    }, interval)
  }

  getCard(player: string): ?PlayedCardType {
    const { tricks } = this.props;
    const { currentTrickIndex } = this.state;

    const trick = tricks[currentTrickIndex];
    return trick && trick.find((card) => card.player === player)
  }

  getWonTricks(player: string): TricksType {
    const { tricks } = this.props;
    return tricks.filter((trick) => {
      const winningCard = trick.find((pc) => pc.winning)
      return winningCard && winningCard.player === player
    })
  }

  renderCard(player: string, position: string) {
    const card = this.getCard(player)

    const landscape = position === "e" || position === "w";

    if (card) {
      return <Card card={card} landscape={landscape} />
    } else {
      return null
    }
  }

  renderPoints(player: string, position: string) {
    const { points } = this.props;
    const tricks = this.getWonTricks(player)

    return (
      <Points tricks={tricks} pointsTotal={points[player]} position={position} />
    )
  }

  render() {
    const { tricks, points } = this.props;
    const { show, currentTrickIndex, showPoints } = this.state;
    const trick = tricks[currentTrickIndex]

    console.log("render Tricks", this.props, this.state);

    return (
      <div className="tricks">
        <style jsx>{`
          .tricks {
            display: flex;
            flex: 1;
            flex-direction: column;
            justify-content: space-between;
          }
          .section {
            display: flex;
            flex-direction: row;
            flex: 1;
          }
          .n {
            visibility: ${show.includes("p3") ? "visible" : "hidden"};
            justify-content: center
          }
          .ew {
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
          }
          .w {
            visibility: ${show.includes("p4") ? "visible" : "hidden"};
          }
          .e {
            visibility: ${show.includes("p2") ? "visible" : "hidden"};
          }
          .s {
            flex-direction: row;
            visibility: ${show.includes("p1") ? "visible" : "hidden"};
            justify-content: center;
            align-items: flex-end;
          }
        `}</style>
        <div className="section n">
          {!showPoints && this.renderCard("p3", "n")}
          {showPoints && this.renderPoints("p3", "n")}
        </div>
        <div className="section ew">
          <div className="w">
            {!showPoints&& this.renderCard("p4", "w")}
            {showPoints && this.renderPoints("p4", "w")}
          </div>
          <div className="e">
            {!showPoints && this.renderCard("p2", "e")}
            {showPoints && this.renderPoints("p2", "e")}
          </div>
        </div>
        <div className="section s">
          {!showPoints && this.renderCard("p1", "s")}
          {showPoints && this.renderPoints("p1", "s")}
        </div>
      </div>
    );
  }
}

export default Tricks;
