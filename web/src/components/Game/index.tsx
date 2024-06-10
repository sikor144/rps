"use client";

import Image from "next/image";
import { Modal } from "@/components/Modal";
import Loader from "@/components/Loader";
import Result from "@/components/Result";
import useGame from "@/hooks/use-game";

const THROWS = ["rock", "paper", "scissors"];

const Game = () => {
  const {
    playerThrow,
    result,
    loading,
    error,
    modalVisible,
    handleThrow,
    handleCloseModal,
  } = useGame();

  return (
    <div className="max-w-[754px] mx-auto">
      <h2 className="font-montserrat mb-10 text-[21px] leading-[25px] text-center">
        SELECT YOUR BET
      </h2>
      <div className="grid grid-cols-1 md:grid-cols-3">
        {THROWS.map((choice) => (
          <button
            className="w-60 rounded-[5px] p-8 m-2 hover:bg-[#f8f8f8] transition-colors capitalize text-center font-montserrat text-[24px] leading-[29px] text-[#36006C] font-medium"
            key={choice}
            onClick={() => handleThrow(choice)}
          >
            <div className="mx-auto mb-6 w-16 h-36">
              <Image
                src={`/${choice}.svg`}
                alt={choice}
                width={64}
                height={139}
                className="max-h-full"
              />
            </div>
            {choice}
          </button>
        ))}
      </div>
      <Modal visible={modalVisible} onClose={handleCloseModal}>
        {loading ? (
          <Loader playerThrow={playerThrow} />
        ) : result ? (
          <Result result={result} onClose={handleCloseModal} />
        ) : error ? (
          <p style={{ color: "red" }}>Error: {error}</p>
        ) : null}
      </Modal>
    </div>
  );
};

export default Game;
