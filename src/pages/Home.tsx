import SectionHeader from "../components/SectionHeader"
import FeatureGrid from "../components/FeatureGrid"

export default function Home() {
  return (
    <main>
      <SectionHeader
        title="Bienvenido a Selene Bot"
        subtitle="La IA más avanzada para Rocket League"
      />
      <FeatureGrid />
    </main>
  )
}