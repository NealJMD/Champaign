// @flow
import React from 'react';
import { FormattedMessage } from 'react-intl';

export default (props: {loading: boolean, children: any}) => {
  if (props.loading) {
    return <FormattedMessage id="loading" defaultMessage="Loading..." />;
  }

  return <span>{ props.children }</span>;
};
