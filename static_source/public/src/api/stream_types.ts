import { parseTime } from '@/utils'

export enum Types {
  INT = 'int',
  STRING = 'string',
  FLOAT = 'float',
  BOOL = 'bool',
  ARRAY = 'array',
  TIME = 'time',
}

export interface Attribute {
  name: string
  type: Types
  value: any
}

export interface State {
  name: string
  description?: string
  icon?: string
  image_url?: string
}

export interface EventState {
  entity_id: string
  attributes: Map<string, Attribute>
  settings: Map<string, Attribute>
  last_changed?: string
  last_updated?: string
  state: State
  value?: string
}

export interface EventStateChange {
  storage_save: boolean
  plugin_name: string
  entity_id: string
  old_state: EventState
  new_state: EventState
}

export function GetAttrValue(attr: Attribute): string {
  let val: string
  switch (attr.type) {
    case Types.INT:
      val = attr.value
      break
    case Types.STRING:
      val = attr.value
      break
    case Types.FLOAT:
      val = attr.value
      break
    case Types.BOOL:
      if (attr.value) {
        val = 'ON'
      } else {
        val = 'OFF'
      }
      break
    case Types.ARRAY:
      val = '[ARRAY]'
      break
    case Types.TIME:
      val = parseTime(attr.value) as string
      break
    default:
      return `unknown type "${attr.type}"`
  }
  return val
}
