export default function SectionHeader({ title, subtitle }: { title: string, subtitle: string }) {
  return (
    <div className="text-center py-12">
      <h2 className="text-4xl font-bold text-white">{title}</h2>
      <p className="mt-2 text-lg text-gray-400">{subtitle}</p>
    </div>
  )
}