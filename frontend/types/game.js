// @flow
import type { HandsType } from "./hand";
import type { TrickType } from "./trick";
import type { CardListType } from "./card";

export type GameType = {|
  id: number,
  talon: CardListType,
  hands: HandsType,
  trick: TrickType
|};
