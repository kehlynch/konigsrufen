// @flow
import type { HandsType } from "./hand";
import type { TricksType } from "./trick";
import type { CardListType } from "./card";
import type { ScoresListType } from "./scores";

export type GameType = {|
  id: number,
  talon: CardListType,
  hands: HandsType,
  tricks: TricksType,
  scoresList: ScoresListType,
  points: pointsType,
  finished: boolean
|};
