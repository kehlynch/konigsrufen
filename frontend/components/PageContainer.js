// @flow

import * as React from "react";

import mediaQueries from "../lib/mediaQueries";

type Props = {
  children: React.Node,
  backgroundColourInner: string,
  backgroundColour: string,
  fixedHeight?: string,
  fixedHeightOffFull?: string
};

class Layout extends React.Component<Props> {
  render() {
    const { children, backgroundColour } = this.props;

    return (
      <div className="root">
        <style jsx>{`
          .root {
            background-color: ${backgroundColour};
            flex: 1 1 100vh;
            height: 100vh;
          }
          @media ${mediaQueries.gtSmall} {
            .outerContainer {
            }
          }
        `}</style>
        {children}
      </div>
    );
  }
}

export default Layout;
