export interface ItemPayloadChart {
  type: string,
  select: Array<string>,
  index: number,
  width: number,
  height: number,
  borderWidth: number,
  xAxis: boolean,
  yAxis: boolean,
  legend: boolean,
}

export interface ChartDataSet {
  label?: string,
  borderColor?: string,
  backgroundColor?: string,
  radius?: number,
  borderWidth?: number,
  data: Array<number>
}
