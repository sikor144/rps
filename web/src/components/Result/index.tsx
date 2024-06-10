import Image from "next/image";

type ResultProps = {
  result: {
    player_throw: string;
    computer_throw: string;
    result: string;
  };
  onClose: () => void;
};

const Result = ({ result, onClose }: ResultProps) => {
  const getResultMessage = () => {
    switch (result.result) {
      case "Player wins":
        return "YOU WIN!";
      case "Computer wins":
        return "YOU LOST!";
      default:
        return "IT'S A TIE!";
    }
  };

  const getOutcomeMessage = () => {
    if (result.result === "Draw") {
      return "Both players chose the same.";
    } else {
      return `Curb with ${result.computer_throw} ${
        result.result === "Player wins" ? "loses" : "wins"
      }.`;
    }
  };

  return (
    <div className="w-96">
      <h2 className="text-[32px] leading-[39px] text-[#36006C] font-montserrat text-center mb-12">
        {getResultMessage()}
      </h2>
      <div className="text-center">{getOutcomeMessage()}</div>
      <div className="flex items-center justify-center mt-8">
        <Image
          src={`/${result.computer_throw}.svg`}
          alt={result.computer_throw}
          width={64}
          height={139}
          className="max-h-[128px]"
        />
      </div>
      <div className="flex justify-center mt-8">
        <button
          onClick={onClose}
          className="px-4 py-2 bg-[#36006C] text-white rounded-[5px] w-full font-montserrat text-[32px] leading-[39px] font-medium"
        >
          Ok
        </button>
      </div>
    </div>
  );
};

export default Result;
