import { useState, useEffect } from 'react'; 
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm'
import styles from "./RemoteMarkdownModal.module.css";

const fetchMarkdown = async (url) => await fetch(url).then(r => r.text()).then(r => r.replace('[here](/data_final).', '[here](/download).'))

export default function RemoteMarkdownModal({
    url=false,
    reset=() => {}
}){ 
    const [markdownText, setMarkdownText] = useState('')

    useEffect(() => {
        try {
            fetchMarkdown(url).then(result => setMarkdownText(result))
        } catch(e) {
            console.log(e)
        }
    },[])

    return <div className={styles.fullScreenModal}>
        <button onClick={reset} className={styles.reset}>
            <span>
                ×
            </span>
        </button>
        <div className={styles.modalContainer}>
            <ReactMarkdown remarkPlugins={[remarkGfm]}>{markdownText}</ReactMarkdown>
        </div>
    </div>
}