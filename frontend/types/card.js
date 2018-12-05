// @flow
export type CardType = {|
  slug: string,
  suit: string,
  points: number,
  value: number
|};

export type CardListType = Array<CardType>;

export const EMPTY_CARD: CardType = {
  slug: "",
  suit: "",
  points: 0,
  value: 0
};
