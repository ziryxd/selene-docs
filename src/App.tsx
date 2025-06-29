import { Routes, Route } from 'react-router-dom'
import Home from './pages/Home'
import Features from './pages/Features'
import Docs from './pages/Docs'
import Contribute from './pages/Contribute'
import Navbar from './components/Navbar'

export default function App() {
  return (
    <div>
      <Navbar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/features" element={<Features />} />
        <Route path="/docs" element={<Docs />} />
        <Route path="/contribute" element={<Contribute />} />
      </Routes>
    </div>
  )
}