// @flow

import { post } from "./api";

import type { CardType } from "../types/card";

export async function postResponse(
  req: ?Request,
  card: CardType,
  gameId: number
) {
  const returnData = await post(req, `/responses`, {
    game_id: gameId,
    player: "p1",
    card_slug: card.slug
  });

  return returnData;
}
