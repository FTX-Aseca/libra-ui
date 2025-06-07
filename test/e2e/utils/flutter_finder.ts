import { Buffer } from 'buffer';

function toBase64(json: object): string {
  return Buffer.from(JSON.stringify(json)).toString('base64');
}

export const find = {
  byValueKey: (key: string | number) => {
    return toBase64({
      finderType: 'ByValueKey',
      keyValueString: key,
      keyValueType: typeof key === 'string' ? 'String' : 'int',
    });
  },
}; 