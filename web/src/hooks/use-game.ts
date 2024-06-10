import { useState } from "react";
import { fetchAPI } from "@/utils/api";

type GameResult = {
  player_throw: string;
  computer_throw: string;
  result: string;
};

const useGame = () => {
  const [playerThrow, setPlayerThrow] = useState<string>("");
  const [result, setResult] = useState<GameResult | null>(null);
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const [modalVisible, setModalVisible] = useState<boolean>(false);

  const handleThrow = async (throwChoice: string) => {
    setLoading(true);
    setPlayerThrow(throwChoice);
    setModalVisible(true);
    setError(null);

    try {
      const data: GameResult = await fetchAPI(`/play/${throwChoice}`);
      setResult(data);
    } catch (err: any) {
      setError(err.info.error || "Unexpected error");
      setResult(null);
    } finally {
      setLoading(false);
    }
  };

  const handleCloseModal = () => {
    setModalVisible(false);
    setResult(null);
    setError(null);
  };

  return {
    playerThrow,
    result,
    loading,
    error,
    modalVisible,
    handleThrow,
    handleCloseModal,
  };
};

export default useGame;
