export const Units = [
  "cm",
  "mm",
  "in",
  "px",
  "pt",
  "pc",
  "em",
  "ex",
  "ch",
  "rem",
  "vh",
  "vw",
  "vmin",
  "vmax",
];

export const Gutter = (props) => {
  const style = {};
  Units.forEach((unit) =>
    props[unit] ? (style.height = `${props[unit]}${unit}`) : null
  );
  return <span style={{...style, display:'block'}}></span>;
};
