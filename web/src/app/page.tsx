import Game from "@/components/Game";

export default function Home() {
  return (
    <div>
      <div className="max-w-[754px] mx-auto mt-32">
        <h1 className="text-3xl tracking-[0px] text-[#36006C] text-[50px] leading-[61px] font-medium font-montserrat mb-10">
          ROCK – PAPER – SCISSORS
        </h1>
        <div className="mt-4 font-roboto font-light text-[21px] leading-[32px] tracking-[0px] opacity-[0.54] mb-9">
          Rock Paper Scissors is a zero sum game that is usually played by two
          people using their hands and no tools. The idea is to make shapes with
          an outstretched hand where each shape will have a certain degree of
          power and will lead to an outcome.
        </div>
      </div>
      <Game />
    </div>
  );
}
