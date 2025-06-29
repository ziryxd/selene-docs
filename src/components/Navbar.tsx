import { Link } from "react-router-dom"

export default function Navbar() {
  return (
    <nav className="flex justify-between items-center p-4 bg-black shadow-md">
      <h1 className="text-2xl font-bold text-cyan-400">Selene Bot</h1>
      <div className="flex gap-4">
        <Link to="/">Inicio</Link>
        <Link to="/features">Características</Link>
        <Link to="/docs">Documentación</Link>
        <Link to="/contribute" className="text-cyan-400 hover:underline">Contribuye</Link>
      </div>
    </nav>
  )
}