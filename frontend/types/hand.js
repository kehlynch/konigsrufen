// @flow
import type { CardListType, PlayedCardListType } from "./card";

export type HandType = {|
  trumps: CardListType,
  spades: CardListType,
  diamonds: CardListType,
  hearts: CardListType,
  clubs: CardListType
|};

export type HandsType = {|
  p1: HandType,
  p2: HandType,
  p3: HandType,
  p4: HandType
|};
