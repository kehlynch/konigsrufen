// @flow

import React from "react";
import { colours, fonts } from "../lib/theme";

type Props = {
  text: string,
  onClick: Function,
  type?: string,
  disabled?: boolean,
  color?: string
};

export default (props: Props) => {
  const { type, disabled } = props;

  return (
    <div className="root">
      <style jsx>{`
        .root {
          display: flex;
          flex: 1;
        }
        button {
          border-radius: 100px;
          font-family: ${fonts.postGrotesk};
          font-size: 14px;
          font-weight: 700;
          text-align: center;
          flex: 1;
          cursor: pointer;
          padding: 4px 16px 5px 16px;
          background-color: ${colours.white};
          color: ${colours.green};
          border: solid 2px;
          border-color: ${colours.green};
        }
        button:focus {
          outline: none;
        }
        button:disabled {
          cursor: not-allowed;
        }
      `}</style>
      <button onClick={props.onClick} className={type} disabled={disabled}>
        {props.text}
      </button>
    </div>
  );
};
