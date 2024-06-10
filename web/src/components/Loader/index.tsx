import Image from "next/image";
import loaderPic from "../../../public/loader.svg";

const Loader = ({ playerThrow }: { playerThrow: string }) => (
  <div className="w-[880px]">
    <h2 className="text-[32px] leading-[39px] text-[#36006C] font-montserrat text-center mb-16">
      WAITING CURB’S CHOOSE
    </h2>
    <div className="grid grid-cols-2 mb-4">
      <div className="mt-4">
        <div className="flex justify-center items-center mb-4 h-36">
          <Image
            src={`/${playerThrow}.svg`}
            alt={playerThrow}
            width={64}
            height={139}
            className="max-h-[128px]"
          />
        </div>
        <div className="text-center text-[21px] leading-[25px] text-[#36006C] font-montserrat font-medium">
          Your bet
        </div>
      </div>
      <div className="text-center mt-4 w-full">
        <div className="h-36 flex items-center justify-center w-full mb-4">
          <Image src={loaderPic} alt="Loading" width={64} height={64} />
        </div>
        <div className="flex justify-center">
          <Image
            src="/curb_logo/curb_logo.png"
            alt="Curb"
            width={64}
            height={139}
          />
        </div>
      </div>
    </div>
  </div>
);

export default Loader;
