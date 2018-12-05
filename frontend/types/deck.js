// @flow
import type { CardListType } from "./card";
import type { HandType } from "./hand";

export type DeckType = {|
  p1: HandType,
  p2: HandType,
  p3: HandType,
  p4: HandType,
  talon: CardListType
|};
