import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
const supabase = createClient(
  'https://kqalafkvbvzbwcxmersn.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtxYWxhZmt2YnZ6YndjeG1lcnNuIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODI0MzY2OTcsImV4cCI6MTk5ODAxMjY5N30.CFv4furULpVNx7Ucb0CsEIPNgldgOQqPoo7GeaCUETQ')

async function session_or_login() {
  const { data } = await supabase.auth.getSession()
  if(data !== null && data.session !== null) {
    return data.session.user
  }
  return login()
}

async function login() {
  await supabase.auth.signInWithOAuth({ provider: 'github', options: { redirectTo: document.URL } })
  const { data } = await supabase.auth.getSession()
  return data.session.user
}

const user = await session_or_login()
const article = document.getElementsByTagName('article')[0].attributes.name.value

// const { error } = await supabase.from('highlights').delete().neq('id', 0)

async function recordHighlight(paragraph, startOffset, endOffset) {
  await supabase.from('highlights').insert({
    article: article, paragraph: paragraph, start: startOffset, end: endOffset
  })
}

const input = document.createElement('input')
input.className = 'comment'

const commentButton = document.createElement('button')
commentButton.textContent = '💬'
commentButton.className = 'add-comment'

async function selectionchange(event) {
  const selection = getSelection()
  if(selection.type == 'Range') {
    const range = selection.getRangeAt(0)
    const paragraph = range.startContainer.parentNode
    if(commentButton.parentNode !== paragraph) {
      paragraph.appendChild(commentButton)
    }
  }
}
    //highlight(range)

    //const paragraph_name = paragraph.attributes.name.value
      //input.focus() // this resets selection
function highlight(range) {
  const paragraph = range.startContainer.parentNode
  const begin = Math.min(range.startOffset, range.endOffset)
  const end = Math.max(range.startOffset, range.endOffset)
  const text = paragraph.textContent
  const before = text.slice(0, begin)
  const mark = text.slice(begin, end)
  const after = text.slice(end, -1)


}

//    recordHighlight(paragraph, range.startOffset, range.endOffset)

document.addEventListener('selectionchange', selectionchange);
