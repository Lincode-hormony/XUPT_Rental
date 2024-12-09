import { BuilderNameConstants } from 'router/src/main/ets/constants/RouterConstants';

export { Mine } from './src/main/ets/components/minePage'

export function harInit(builderName:string){
  switch (builderName){
    case BuilderNameConstants.MINE_LOGIN:
      import('./src/main/ets/components/login')
    break
    case BuilderNameConstants.MINE_LOGINCODE:
      import('./src/main/ets/components/loginCode')
      break
    case BuilderNameConstants.MINE_MINEPAGE:
      import('./src/main/ets/components/minePage')
      break
    default :
      break
  }
}
