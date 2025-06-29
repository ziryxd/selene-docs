const features = [
  { title: "Air Dribbling", description: "Precisión total en el aire." },
  { title: "Shadow Defense", description: "Defensa con inteligencia posicional." },
  { title: "50/50 Inteligente", description: "Decisiones perfectas en desafíos." }
];

export default function FeatureGrid() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-6 px-6 pb-12">
      {features.map((feature, i) => (
        <div key={i} className="bg-gray-800 p-6 rounded-lg text-center shadow-lg">
          <h3 className="text-xl font-semibold text-cyan-300">{feature.title}</h3>
          <p className="text-gray-300 mt-2">{feature.description}</p>
        </div>
      ))}
    </div>
  )
}