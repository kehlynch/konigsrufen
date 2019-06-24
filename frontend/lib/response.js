// @flow

import { post } from "./api";

import type { CardType } from "../types/card";

export async function postResponse(
  req: ?Request,
  card: CardType,
  gameId: number
) {
  const response = await post(req, `/responses`, {
    game_id: gameId,
    player: "p1",
    card_slug: card.slug
  });

  console.log("postResponse response", response);

  return response;
}
