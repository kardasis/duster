export const externalTooltipHandler = (tooltipElem: HTMLElement, summaries) => {
  return (context) => {
    const { chart, tooltip } = context;
    const { offsetLeft: positionX, offsetTop: positionY } = chart.canvas;
    tooltipElem.style.opacity = '1';

    if (tooltip.caretX + tooltipElem.offsetWidth / 2 > chart.width) {
      tooltipElem.style.left = positionX + chart.width - tooltipElem.offsetWidth / 2 + 'px';
    } else {
      tooltipElem.style.left = positionX + tooltip.caretX + 'px';
    }
    tooltipElem.style.top = positionY + tooltip.caretY + 'px';
    tooltipElem.style.font = tooltip.options.bodyFont.string;
    tooltipElem.style.padding = tooltip.options.padding + 'px ' + tooltip.options.padding + 'px';

    const { dataIndex, datasetIndex } = chart.tooltip.dataPoints[0]
    const summary = summaries[datasetIndex][dataIndex]

    tooltipElem.dispatchEvent(new CustomEvent(
      'update-tooltip',
      { detail: summary }
    ))
  }
}

