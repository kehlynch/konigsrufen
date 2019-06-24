// @flow
export type CardType = {|
  slug: string,
  suit: string,
  points: number,
  value: number,
  legal?: boolean
|};

export type PlayedCardType = {|
  slug: string,
  suit: string,
  points: number,
  value: number,
  legal: boolean,
  player: string,
  winning: boolean,
  show?: boolean
|}

export type CardListType = Array<CardType>;
export type PlayedCardListType = Array<PlayedCardType>;
