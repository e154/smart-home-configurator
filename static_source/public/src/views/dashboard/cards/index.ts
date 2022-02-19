export {default as FrontendVersion} from './frontend-version/index.vue';
export {default as Dummy} from './dummy/index.vue';
export {default as Button} from './button/index.vue';

export const CardName = (name: string): string => {
  switch (name) {
    case 'button':
      return 'Button';
    case 'frontend-version':
      return 'FrontendVersion';
    default:
      // console.error(`unknown card name "${name}"`);
      return 'Dummy';
  }
};
