// @flow
import React from 'react';
import { FormattedMessage } from 'react-intl';
import { camelizeKeys } from '../util';

export type ErrorMap = {
  [key: string]: any[],
};

export type OperationResponse = {
  success: boolean,
  errors: ErrorMap,
};

export const parseResponse = (response: any): OperationResponse => {
  switch (response.status) {
    case 200:
    case 201:
    case 204:
      return { success: true, errors: {} };
    case 422:
      return {
        success: false,
        errors: camelizeKeys(response.responseJSON.errors),
      };
    default:
      return {
        success: false,
        errors: {
          base: [
            <FormattedMessage
              id="call_tool.errors.unknown" // TODO use generic error and allow customization
              defaultMessage={`Unknown error, code ${response.code}`}
            />,
          ],
        },
      };
  }
};
