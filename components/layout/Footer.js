import styles from "./Footer.module.css";

export default function Footer() {
  return (
    <footer className={styles.footer}>
      <a
        href="https://geodacenter.github.io/"
        target="_blank"
        rel="noopener noreferrer"
      >
        <span className={styles.logo}>
          <img src="/geoda-logo.png" alt="Geoda Logo" width={23} height={20} />
        </span>
        Powered by Geoda
      </a>
    </footer>
  );
}
